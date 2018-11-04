/* global Promise */

import { createSelector } from 'reselect'
import { Map } from 'immutable'
import win from '../window'
import yaml from 'js-yaml'
import UrlParse from 'url-parse'

const parseJSON = (data) => {

  var result = undefined
  try {
    result = JSON.parse(data)
  } catch (e) {
    console.error('JSON Parse error', e)
  }
  return result
}
const parseYAML = (data) => {

  var result = undefined
  try {
    result = yaml.safeLoad(data)
  } catch (e) {
    console.error('YAML Parse error', e)
  }
  return result
}
const parseText = (data) => {
  var result = parseJSON(data)
  if (!result) {
    result = parseYAML(data)
  }
  return result
}

const rewriteSwagger = ({originalSwagger, parsedOriginalUrl, proxyHost}) => {

  try {
    console.log('ORIGINAL IS ', originalSwagger)

    if (!originalSwagger.host  ) {
         originalSwagger.host= `${parsedOriginalUrl.protocol}//${parsedOriginalUrl.host}`
    }
    if (originalSwagger.host.indexOf('http') !== 0) {

      console.log('Proxy Url no protocol found')
      // protocol is not provided in swagger def
      originalSwagger.host = `${parsedOriginalUrl.protocol}//${originalSwagger.host}`

      console.log('Proxy Url protocol added', originalSwagger.host)
    }

    const originalSwaggerhostParsed = new UrlParse(originalSwagger.host)
    console.log('ORIGINAL IS ', originalSwagger)

    const hostRewrite = originalSwaggerhostParsed.hostname.replace('localhost', parsedOriginalUrl.hostname)
    console.log('Checking parsedOriginalUrl', parsedOriginalUrl)
    console.log('Checking originalSwaggerhostParsed', originalSwaggerhostParsed)
    console.log('Checking originalSwagger.host', originalSwagger.host)
    console.log('Checking hostRewrite ', hostRewrite)
    originalSwagger.host = `${proxyHost}/proxy/http://${hostRewrite || parsedOriginalUrl.hostname}:${parsedOriginalUrl.port || '80'}`

    console.log('Swagger Rewritten is', originalSwagger.host)
  } catch (e) {
    console.error('Error while rewriting swagger urls to proxy', e)
  }
  return originalSwagger
}

export default function downloadUrlPlugin (toolbox) {
  let {fn} = toolbox

  const actions = {
    download: (url) => ({errActions, specSelectors, specActions, getConfigs}) => {
      console.log('Downloading swagger file json/yaml')
      let {fetch} = fn
      const config = getConfigs()
      url = url || specSelectors.url()
      specActions.updateLoadingStatus('loading')
      errActions.clear({source: 'fetch'})
      const parsedOriginalUrl = new UrlParse(url)
      // FIXME: TODO: remove redundancy
      const proxyHost = `${window.location.hostname}:${window.location.port}`
      const proxy = `${window.location.protocol}//${proxyHost}/proxy/`
      const proxyUrl = `${proxy}${url}`
      console.log('Original Url ', url)
      console.log('Original Url ', parsedOriginalUrl)
      console.log('Proxy Url ', proxyUrl)
      fetch({
        url: proxyUrl,
        loadSpec: true,
        requestInterceptor: config.requestInterceptor || (a => a),
        responseInterceptor: config.responseInterceptor || (a => a),
        credentials: 'same-origin',
        headers: {
          'Accept': 'application/json,*/*'
        }
      }).then(next, next)

      function next (res) {
        if (res instanceof Error || res.status >= 400) {
          specActions.updateLoadingStatus('failed')
          errActions.newThrownErr(Object.assign(new Error((res.message || res.statusText) + ' ' + url), {source: 'fetch'}))
          // Check if the failure was possibly due to CORS or mixed content
          if (!res.status && res instanceof Error) checkPossibleFailReasons()
          return
        }

        console.log('Received Stuff ', res)
        var bodyText = res.text

        console.log('Application JSON Received PROXYING API URL')
        const originalSwagger = parseText(bodyText)
        bodyText = JSON.stringify(rewriteSwagger({
          originalSwagger,
          parsedOriginalUrl,
          proxyHost
        }))
        specActions.updateLoadingStatus('success')
        specActions.updateSpec(bodyText)
        if (specSelectors.url() !== url) {
          specActions.updateUrl(url)
        }
      }

      function checkPossibleFailReasons () {
        try {
          let specUrl

          if ('URL' in win) {
            specUrl = new URL(url)
          } else {
            // legacy browser, use <a href> to parse the URL
            specUrl = document.createElement('a')
            specUrl.href = url
          }

          if (specUrl.protocol !== 'https:' && win.location.protocol === 'https:') {
            const error = Object.assign(
              new Error(`Possible mixed-content issue? The page was loaded over https:// but a ${specUrl.protocol}// URL was specified. Check that you are not attempting to load mixed content.`),
              {source: 'fetch'}
            )
            errActions.newThrownErr(error)
            return
          }
          if (specUrl.origin !== win.location.origin) {
            const error = Object.assign(
              new Error(`Possible cross-origin (CORS) issue? The URL origin (${specUrl.origin}) does not match the page (${win.location.origin}). Check the server returns the correct 'Access-Control-Allow-*' headers.`),
              {source: 'fetch'}
            )
            errActions.newThrownErr(error)
          }
        } catch (e) {
          return
        }
      }

    },

    updateLoadingStatus: (status) => {
      let enums = [null, 'loading', 'failed', 'success', 'failedConfig']
      if (enums.indexOf(status) === -1) {
        console.error(`Error: ${status} is not one of ${JSON.stringify(enums)}`)
      }

      return {
        type: 'spec_update_loading_status',
        payload: status
      }
    }
  }

  let reducers = {
    'spec_update_loading_status': (state, action) => {
      return (typeof action.payload === 'string')
        ? state.set('loadingStatus', action.payload)
        : state
    }
  }

  let selectors = {
    loadingStatus: createSelector(
      state => {
        return state || Map()
      },
      spec => spec.get('loadingStatus') || null
    )
  }

  return {
    statePlugins: {
      spec: {
        actions,
        reducers,
        selectors
      }
    }
  }
}
