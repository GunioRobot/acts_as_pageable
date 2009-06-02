module ActsAsPageable

  module GlobalSettings

    @@settings = {
      :page               => 1,
      :items_per_page     => 10, 
      :window_offset      => 2, 
      :max_items_per_page => 200, 
      :min_items_per_page => 5,
      :min_window_offset  => 1, 
      :max_window_offset  => 20
    }

    def self.settings=(options)
      @@settings.merge!(options)
    end
    
    def self.settings
      @@settings
    end

  end

end

