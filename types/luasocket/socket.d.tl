local ltn12 = require("ltn12")
local Sink = ltn12.Sink
local Source = ltn12.Source

local record socket
   record TCP
      -- master methods
      bind: function(TCP, string, number)
      connect: function(TCP, string, number): number, string
      listen: function(TCP, number): number, string

      -- client methods
      getpeername: function(TCP): string, number

      enum TCPReceivePattern
         "*l"
         "*a"
      end
      enum TCPReceiveError
         "closed"
         "timeout"
      end
      receive: function(TCP): string, TCPReceiveError
      receive: function(TCP, TCPReceivePattern|number): string, TCPReceiveError
      receive: function(TCP, TCPReceivePattern|number, string): string, TCPReceiveError

      send: function(TCP, string): number, string, number
      send: function(TCP, string, number): number, string, number
      send: function(TCP, string, number, number): number, string, number

      enum TCPShutdownMode
         "both"
         "send"
         "receive"
      end
      shutdown: function(TCP, TCPShutdownMode): number

      -- server methods
      accept: function(TCP): TCP, string

      -- client and server methods
      enum TCPOption
         "keepalive"
         "reuseaddr"
         "tcp-nodelay"
      end
      enum TCPLinger
         "linger"
      end
      record TCPLingerOption
         on: boolean
         timeout: number
      end
      setoption: function(TCP, TCPOption): number
      setoption: function(TCP, TCPLinger, TCPLingerOption): number

      -- master, client, and server methods
      close: function(TCP)

      getsockname: function(TCP): string, number

      getstats: function(TCP): number, number, number

      setstats: function(TCP, number, number, number): number

      enum TCPTimeoutMode
         "b"
         "t"
      end
      settimeout: function(TCP, number, TCPTimeoutMode)
   end
   record UDP
      close: function(UDP)

      getpeername: function(UDP): string, number

      getsockname: function(UDP): string, number

      enum UDPTimeout
         "timeout"
      end
      receive: function(UDP): string, UDPTimeout
      receive: function(UDP, number): string, UDPTimeout

      receivefrom: function(UDP): string, string, number, UDPTimeout
      receivefrom: function(UDP, number): string, string, number, UDPTimeout

      send: function(UDP, string): number, string

      sendto: function(UDP, string, string, number): number, string

      setpeername: function(UDP, string): number, string
      setpeername: function(UDP, string, number): number, string

      setsockname: function(UDP, string, number): number, string

      enum UDPOptions
         "dontroute"
         "broadcast"
      end
      setoption: function(UDP, UDPOptions): number, string
      setoption: function(UDP, UDPOptions, boolean): number, string

      settimeout: function(UDP, number)
   end
   tcp: function(): TCP, string

   udp: function(): UDP, string

   record dns
      record DNSResolved
         name: string
         alias: {string}
         ip: {string}
      end
      toip: function(): string
      tohostname: function(string): string, DNSResolved|string
      gethostname: function(string): string, DNSResolved|string
   end

   bind: function(string, number): TCP
   bind: function(string, number, number): TCP

   connect: function(string, number): TCP
   connect: function(string, number, string): TCP
   connect: function(string, number, string, number): TCP

   _DEBUG: boolean

   newtry: function(function): function

   protect: function(function): function

   -- tagged records/Table Union types would be nice here,
   -- as this should be {TCP|UDP}
   -- but I imagine this should be fine for most uses
   select: function({UDP}, {UDP}): {UDP}, {UDP}, string
   select: function({TCP}, {TCP}): {TCP}, {TCP}, string
   select: function({UDP}, {UDP}, number): {UDP}, {UDP}, string
   select: function({TCP}, {TCP}, number): {TCP}, {TCP}, string

   enum SinkMode
      "http-chunked"
      "close-when-done"
      "keep-open"
   end

   sink: function(SinkMode, UDP): Sink<string>
   sink: function(SinkMode, TCP): Sink<string>

   skip: function(number, ...: any): any...

   sleep: function(number)

   enum SourceMode
      "http-chunked"
      "by-length"
      "until-closed"
   end

   source: function(SourceMode, TCP): Source<string>
   source: function(SourceMode, UDP): Source<string>
   source: function(SourceMode, TCP, number): Source<string>
   source: function(SourceMode, UDP, number): Source<string>

   gettime: function(): number

   try: function(...: any): any...

   _VERSION: string
end

return socket
