require "openbd_api"
require "logger"

logger = Logger.new(STDERR)
logger.level = Logger::DEBUG

N = 10_000
MAX_REQ = 10 # if you want to get all data, use `nil`

client = OpenBD::Client.new()
coverage = client.coverage.body

coverage.each_slice(N).with_index do |list, i|
  break if MAX_REQ && i >= MAX_REQ
  logger.debug "req: #{i}..."

  client.bulk_get(list).each do |item|
    summary = item.summary
    print "#{summary.isbn}: #{summary.title}\n"

    ## to reduce outputs, show only first title
    break
  end
end

