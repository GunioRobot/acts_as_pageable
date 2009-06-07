module ActsAsPageable

  module PresentationModel

    module Base
      def self.included(receiver)
        receiver.extend Console
      end

      def self.extend_object(receiver)
        receiver.extend Console
      end
    end

    module Console
      def render_pagination_references
        return "don't have any page" if self.total_pages < 1
      end
    end
      
    module Html
      def render_pagination_references(url=nil,css_class_name)
        return "" if self.total_pages < 1
        url = url.nil? || url.empty? ? '?' : url << '&'
        <<-HTML
        <div class="pagination-#{css_class_name}">
          <ul class="paginate button-tab">
            <li class="text-nav prev">
              <%unless page[:page] == 1 %>
                <a href="#{url}page=#{self.previous_page}">anterior</a>
              <% else %>
                <span>anterior</span>
              <%end%>
            </li>
            <% if page[:page] > page[:window_offset]+1 %>
              <li>
                <a href="<%=url%>page=1">1</a>
              </li>
            <% end %>
            <% if page[:page] > page[:window_offset]+2 %>
              <li>
                <a href="<%=url%>page=2">2</a>
              </li>
            <% end %>
            <% if page[:page] > page[:window_offset]+3 %>
              <li class="etc">
                ...
              </li>
            <% end %>
            <% page[:previous_pages_numbers].sort.each do |n| %>
              <li>
                <a href="<%=url%>page=<%=n%>"><%=n%></a>
              </li>
            <%end%>
            <li class="selected">
              <a href="<%=url%>page=<%=page[:page]%>"><%=page[:page]%></a>
            </li>
            <% page[:next_pages_numbers].each do |n| %>
              <li>
                <a href="<%=url%>page=<%=n%>"><%=n%></a>
              </li>
            <%end%>
            <% if page[:page] < page[:total_pages]-page[:window_offset]-2 %>
              <li class="etc">
                ...
              </li>
            <% end %>
            <% if page[:page] < page[:total_pages]-page[:window_offset]-1 %>
              <li>
                <a href="<%=url%>page=<%=page[:total_pages]-1%>"><%=page[:total_pages]-1%></a>
              </li>
            <% end %>
            <% if page[:page] < page[:total_pages]-page[:window_offset] %>
              <li>
                <a href="<%=url%>page=<%=page[:total_pages]%>"><%=page[:total_pages]%></a>
              </li>
            <% end %>
            <li class="text-nav next">
              <%unless page[:page] == page[:total_pages] %>
                <a href="<%=url%>page=<%= page[:next_page] %>">próximo</a>
              <% else %>
                <span>próximo</span>
              <%end%>
            </li>
          </ul>
        </div>
        HTML
      end
    end

  end

end
