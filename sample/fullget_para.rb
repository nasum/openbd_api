require "openbd_api"
require "faraday_middleware/parse_oj"
require "parallel"
require "logger"

logger = Logger.new(STDERR)
logger.level = Logger::DEBUG

N = 10_000
MAX_PARA = 4
MAX_REQ = 10 # if you want to get all data, use `nil`

client = OpenBD::Client.new(response_parser: :oj)
coverage = client.coverage.body

Parallel.each_with_index(coverage.each_slice(N),
                         in_processes: MAX_PARA) do |list, i|
  raise Parallel::Break if MAX_REQ && i >= MAX_REQ
  logger.debug "req: #{i}..."

  client.bulk_get(list).each do |item|
    summary = item.summary
    print "#{summary.isbn}: #{summary.title}\n"

    ## to reduce outputs, show only first title
    break
  end
end
