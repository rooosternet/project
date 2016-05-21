CarrierWave.configure do |config|
	# config.permissions = 0666
 #  	config.directory_permissions = 0777
  	config.storage = :file
	config.remove_previously_stored_files_after_update = false
	# config.ignore_integrity_errors = false
	# config.ignore_processing_errors = false
	# config.ignore_download_errors = false  
end  