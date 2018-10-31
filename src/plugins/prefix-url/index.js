export function SomePlugin (toolbox) {

  const UPDATE_SOMETHING = 'some_namespace_update_something' // strings just need to be uniuqe... see below

  // Tools
  const fromJS = toolbox.Im.fromJS // needed below
  const createSelector = toolbox.createSelector // same, needed below

  return {
    statePlugins: {

      someNamespace: {

        wrapActions: {
          spec_set_mutated_request: (oriAction, system) => (...args) => {
            oriAction(...args) // Usually we at least call the original action

            console.log('args', args) // Log the args
            // anotherAction in the someNamespace has now been replaced with the this function
          }
        }
      }

    }
  }
}
