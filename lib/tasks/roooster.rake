namespace :roooster do
	desc <<-END_DESC
	this rake populate fake freelancers
	Examples:
	rake roooster:populate_freelancer RAILS_ENV="production"
    rake roooster:import_users_from_file RAILS_ENV="production" 
    rake roooster:populate_admins RAILS_ENV="production" 
	END_DESC
    

    task :populate_admins, [] => :environment do |t , args| 
        populate_admin_users
    end

	task :populate_freelancer, [] => :environment do |t , args| 
        populate
    end

    task :import_users_from_file, [] => :environment do |t , args| 
        import_users
    end

    private

    def populate_admin_users
        emails = ["yossi@roooster.net","sam@roooster.net","rotem@roooster.net"]
        users = [
            {"firstname"=>"yossi", "lastname"=>"edri", "email"=>"yossi@roooster.net"},
            {"firstname"=>"sam", "lastname"=>"miller", "email"=>"sam@roooster.net"},
            {"firstname"=>"rotem", "lastname"=>"nahlieli", "email"=>"rotem@roooster.net"}
            ]
            
        start = Time.now
        puts "populate_admin_users: #{start}"
        User.where(email: emails).collect(&:destroy)
        
        ActiveRecord::Base.transaction do
            begin
                users.each do |user|
                    _user = User.create!(user)
                    puts _user.inspect
                end 
            rescue Exception => e
                puts e.message
            end
        end

        end_time = Time.now
        puts "done: #{end_time}   #{end_time-start}"

    end

    def populate
    	emails = ["tonyzagoraios@hotmail.com","nejc@twistedpoly.com","hello@iamgraphicartist.com","piero.desopo@gmail.com","mony@hotmail.com","lopa@twistedpoly.com","loni@iamgraphicartist.com","ra@gmail.com"]
    	users = [
    		{"firstname"=>"Tony", "lastname"=>"Zagoraios", "email"=>"tonyzagoraios@hotmail.com","freelancer_attributes"=>{"email"=>"tonyzagoraios2@hotmail.com","location"=>"London, UK", "online_portfolio"=>"www.artonemotion.com", "linkedin_profile"=>"www.artonemotion.com", "behance"=>"www.artonemotion.com", "vimeo"=>"www.artonemotion.com", "skills"=>"Motion Graphics, Animation, Art Direction, Design, After Effects, Cinema 4D, Final Cut, Illustrator, Photoshop"}},
    		{"firstname"=>"Nejc", "lastname"=>"Polovsak", "email"=>"nejc@twistedpoly.com","freelancer_attributes"=>{"email"=>"nejc2@twistedpoly.com","location"=>"Slovenia", "online_portfolio"=>"www.twistedpoly.com", "linkedin_profile"=>"www.twistedpoly.com", "behance"=>"www.twistedpoly.com", "vimeo"=>"www.twistedpoly.com", "skills"=>"Motion Graphics, Animation, Art Direction, Design, After Effects, Cinema 4D, Final Cut, Illustrator, Photoshop, Premiere, Maya"}},
    		{"firstname"=>"Miguel", "lastname"=>"Rato", "email"=>"hello@iamgraphicartist.com","freelancer_attributes"=>{"email"=>"hello@iamgraphicartist.com","location"=>"London,UK", "online_portfolio"=>"http://iamgraphicartist.com", "linkedin_profile"=>"http://iamgraphicartist.com", "behance"=>"http://iamgraphicartist.com", "vimeo"=>"http://iamgraphicartist.com", "skills"=>"Motion Graphics, Animation, Art Direction, Design, Graphic Design, Typography, UI, After Effects, Cinema 4D, Final Cut, Illustrator, Photoshop"}},
    		{"firstname"=>"Piero", "lastname"=>"Desopo", "email"=>"piero.desopo@gmail.com","freelancer_attributes"=>{"email"=>"piero.desopo2@gmail.com","location"=>"LA, USA", "online_portfolio"=>"http://www.phoenixart.com", "linkedin_profile"=>"http://www.phoenixart.com", "behance"=>"http://www.phoenixart.com", "vimeo"=>"http://www.phoenixart.com", "skills"=>"Director, Motion Graphics, Animation, Art Direction, Design, Illustrator, After Effects, Cinema 4D, Final Cut, Illustrator, Photoshop, Premiere, Maya"}},
    		{"firstname"=>"Moni", "lastname"=>"Xudo", "email"=>"mony@hotmail.com","freelancer_attributes"=>{"email"=>"mony@hotmail.com","location"=>"London, UK", "online_portfolio"=>"www.artonemotion.com", "linkedin_profile"=>"www.artonemotion.com", "behance"=>"www.artonemotion.com", "vimeo"=>"www.artonemotion.com", "skills"=>"Motion Graphics, Animation, Art Direction, Design, After Effects, Cinema 4D, Final Cut, Illustrator, Photoshop"}},
    		{"firstname"=>"Lope", "lastname"=>"Polo", "email"=>"lopa@twistedpoly.com","freelancer_attributes"=>{"email"=>"lopa2@twistedpoly.com","location"=>"Slovenia", "online_portfolio"=>"www.twistedpoly.com", "linkedin_profile"=>"www.twistedpoly.com", "behance"=>"www.twistedpoly.com", "vimeo"=>"www.twistedpoly.com", "skills"=>"Motion Graphics, Animation, Art Direction, Design, After Effects, Cinema 4D, Final Cut, Illustrator, Photoshop, Premiere, Maya"}},
    		{"firstname"=>"Loni", "lastname"=>"Pato", "email"=>"loni@iamgraphicartist.com","freelancer_attributes"=>{"email"=>"loni2@iamgraphicartist.com","location"=>"London,UK", "online_portfolio"=>"http://iamgraphicartist.com", "linkedin_profile"=>"http://iamgraphicartist.com", "behance"=>"http://iamgraphicartist.com", "vimeo"=>"http://iamgraphicartist.com", "skills"=>"Motion Graphics, Animation, Art Direction, Design, Graphic Design, Typography, UI, After Effects, Cinema 4D, Final Cut, Illustrator, Photoshop"}},
    		{"firstname"=>"Raphi", "lastname"=>"Engel", "email"=>"ra@gmail.com","freelancer_attributes"=>{"email"=>"ra2@gmail.com","location"=>"LA, USA", "online_portfolio"=>"http://www.phoenixart.com", "linkedin_profile"=>"http://www.phoenixart.com", "behance"=>"http://www.phoenixart.com", "vimeo"=>"http://www.phoenixart.com", "skills"=>"Director, Motion Graphics, Animation, Art Direction, Design, Illustrator, After Effects, Cinema 4D, Final Cut, Illustrator, Photoshop, Premiere, Maya"}}
  			]
    	start = Time.now
    	puts "populate_freelancer: #{start}"

        User.where(email: emails).collect(&:destroy)
        puts "populating freelancers..."
        
        ActiveRecord::Base.transaction do
        	begin
        		users.each do |user|
        			user = User.new(user)
        			user.save(validate: false)
        			user.role=1
        			user.save(validate: false)
        			puts user.inspect
        		end	
        	rescue Exception => e
        		puts e.message
        	end
        end

        end_time = Time.now
        puts "done: #{end_time}   #{end_time-start}"

    end


    def import_users
       start = Time.now
       puts "import users: #{start}"
       puts "populating users..."
       
        users = []
        begin
            workbook = Roo::Spreadsheet.open("#{Rails.root}/doc/Users_2015_12_18.xlsx", extension: :xlsx)
            workbook.default_sheet = workbook.sheets[0]
            
            freelancers = 0
            workbook.each do |row|
                # ["First", "Last", "Experience", "Website", "Email", "Location", "Linkedin", "Behance", "Vimeo", "Skills"] 
                user = {
                    "firstname" => row[0],
                    "lastname" => row[1],
                    "email" => row[4],
                    "freelancer_attributes"=>{
                        "email" => row[4],
                        "location" => row[5],
                        "online_portfolio" => row[3],
                        "linkedin_profile" => row[6],
                        "behance" => row[7],
                        "vimeo" => row[8],
                        "skills" => row[9]
                    }
                }
                users << user unless freelancers == 0
                # puts "freelancer: #{user.inspect}" unless freelancers == 0
                freelancers+=1
            end 

            workbook.default_sheet = workbook.sheets[1]
            studios = 0
            workbook.each do |row|
                # ["First", "Last", "Company Name", "Title", "Website", "Email", "Location"]
                user = {
                    "firstname" => row[0],
                    "lastname" => row[1],
                    "email" => row[5],
                    "studio_attributes"=>{
                        "email" => row[5],
                        "location" => row[6],
                        "company_name" => row[2],
                        "job_title" => row[6],
                        "company_website" => row[4]                    
                    }
                }
                users << user  unless  studios == 0
                # puts "studio: #{user.inspect}" unless  studios == 0
                studios +=1
            end 
        rescue Exception => e
            puts e.message
        end
        
        puts "Importing #{freelancers} freelancers and #{studios} studios total:#{users.count}"
        
        users.each do |user|
            begin
                unless _user = User.where(email: user["email"]).first 
                 _user = User.create!(user.dup.except("freelancer_attributes","studio_attributes")) 
                end 
                Freelancer.create!(user["freelancer_attributes"].merge!({user_id: _user.id})) unless user["freelancer_attributes"].blank?
                Studio.create!(user["studio_attributes"].merge!({user_id: _user.id})) unless user["studio_attributes"].blank?
                puts _user.inspect

            rescue Exception => e
                puts e.message
            end
        end 
        end_time = Time.now
        puts "done populating users: #{end_time}   #{end_time-start}"
    end

end
