type GatewayRequest: void {
  file: string
}

type GatewayResponse: void {
  file: string
}

interface GatewayInterface {
  RequestResponse:
    default(undefined)(undefined)
}