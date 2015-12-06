namespace :roooster do
	desc <<-END_DESC
	this rake populate fake freelancers
	Examples:
	rake roooster:populate_freelancer RAILS_ENV="production" 
	END_DESC

	task :populate_freelancer, [] => :environment do |t , args| 
        # include Redmine::I18n
        populate
    end

    private

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


end
