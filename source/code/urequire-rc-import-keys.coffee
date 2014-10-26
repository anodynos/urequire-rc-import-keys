_ = require 'lodash'

module.exports = [
  '+import-keys'

  ['**/*.js']

  (m)->
    for moduleName, importedKeyVars of @options when moduleName isnt m.path
      if _.isEmpty(depVariable = m.bundle.all_depsVars[moduleName]?[0])
        throw new Error """"
          `urequire-rc-import-keys` error: Module '#{moduleName}' has no associated variable in depsVars.
           Declare it in `bundle.dependencies: xxx:`"""
      else
        if not _.isEmpty importedKeyVars
          m.mergedCode = '' if not m.mergedCode
          m.mergedCode += "var " +
            _.map(importedKeyVars, (ikv, idxOrKey)->
              if _.isArray importedKeyVars
                varName =
                  if _.isString ikv
                    ikv
                  else if _.isArray ikv
                    ikv[1]
                  else
                    throw new Error "Import error: while importing from module '#{moduleName}' imporedKeyVar #{ikv}"

                keyName = if _.isString ikv then ikv else ikv[0]
              else # its an {}
                varName = ikv
                keyName = idxOrKey

              """#{varName} = #{depVariable}["#{keyName}"]"""
            ).join(',') + ";\n"
]