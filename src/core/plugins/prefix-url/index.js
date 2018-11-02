

export function SomePlugin (toolbox) {

  // Tools
  const fromJS = toolbox.Im.fromJS // needed below
  const createSelector = toolbox.createSelector // same, needed below

  return {
    statePlugins: {

      someNamespace: {

        selectors: {
          // creatSelector takes a list of fn's and passes all the results to the last fn.
          // eg: createSelector(a => a, a => a+1, (a,a2) => a + a2)(1) // = 3
          something: createSelector( // see [reselect#createSelector](https://github.com/reactjs/reselect#createselectorinputselectors--inputselectors-resultfunc)
            getState => getState(), // This is a requirement... because we `bind` selectors, we don't want to bind to any particular state (which is an immutable value) so we bind to a function, which returns the current state
            state => state.get("something") // return the whatever "something" points to
          ),
          foo: getState => "bar" // In the end selectors are just fuctions that we pass getState to
        }
      }

    }
  }
}
