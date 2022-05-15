type CompileRequest: void {
  contents: string
  base: string
  type: string
}

interface DonatelloInterface {
    RequestResponse: compile(CompileRequest)(string),
    RequestResponse: getLastModified(string)(long)
}

outputPort Donatello {
    interfaces: DonatelloInterface
}