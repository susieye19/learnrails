module ApplicationHelper
	def coderay(text)
		notes = text
		# scanned = notes.scan(/\<code(?: lang="(.+?)")\>(.+?)\<\/code\>/m)
		# puts "Scanned is #{scanned}"

		# indices = []
		# scanned.each_with_index do |scan, index|
		# 	unless scan[0].blank?
		# 		indices.push(index)
		# 	end
		# end
		# puts "indices is #{indices}"

		loops = notes.scan(/\<code(?: lang="(.+?)")\>(.+?)\<\/code\>/m).length

		loops.times {
			notes.sub!(/\<code(?: lang="(.+?)")\>(.+?)\<\/code\>/m) do
	      content_tag("notextile", CodeRay.scan($2, $1).div(:css => :class).html_safe)
			end
		}
		# puts "Notes is #{notes}"
		return notes
	end
end
