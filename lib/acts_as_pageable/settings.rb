module ActsAsPageable

  module GlobalSettings

    @@settings = {
      :page               => 1,
      :items_per_page     => 10, 
      :window_offset      => 5, 
      :max_items_per_page => 200, 
      :min_items_per_page => 5,
      :max_window_offset  => 10,
      :min_window_offset  => 5 
    }

    def self.settings=(settings)
      @@settings.merge!(settings)
    end
    
    def self.settings
      @@settings
    end

  end

end

