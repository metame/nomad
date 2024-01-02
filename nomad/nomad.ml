module Adapter = Adapter
module Handler = Handler
module Request = Request
module Protocol = Protocol

let start_link ?acceptor_count ?transport ~port ~handler () =
  Atacama.start_link ~port ?acceptor_count ?transport
    (module Connection_handler)
    (Connection_handler.make ~handler ())

let trail tr conn req =
  match Trail.handler (module Adapter) tr conn req with
  | `upgrade upgrade -> Handler.Upgrade upgrade
  | `close -> Handler.Close conn
