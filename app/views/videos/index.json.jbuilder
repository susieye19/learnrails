json.array!(@videos) do |video|
  json.extract! video, :id, :title, :category, :notes, :transcript, :url
  json.url video_url(video, format: :json)
end
