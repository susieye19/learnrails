Paperclip::Attachment.default_options[:storage]         = :s3
Paperclip::Attachment.default_options[:s3_credentials]  = {
                                                            :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
                                                            :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
                                                          }
Paperclip::Attachment.default_options[:bucket]          = ENV['AWS_BUCKET']
# Paperclip::Attachment.default_options[:url]             = ":s3_path_url"
Paperclip::Attachment.default_options[:path]            = "/:class/:attachment/:id/:style/:basename.:extension"