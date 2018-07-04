module LinkScraper
  class Scrape
    # attr_accessor :text_criteria, :path_criteria

    def initialize(args={})
      @text_scrub = ScrubDb::Strings.new(args.fetch(:text_criteria, {}))
      @path_scrub = ScrubDb::Strings.new(args.fetch(:path_criteria, {}))
      @noko = Mechanizer::Noko.new
      # stock_hsh = {stock_texts: stock_texts, stock_links: stock_links}
      # stock_hsh = {stock_texts: stock_texts, stock_links: stock_links}
    end


    def start(url)
      noko_hash = @noko.scrape({url: url})
      binding.pry
      link_hashes = noko_hash[:texts_and_hrefs]
      binding.pry
      
      err_msg = noko_hash[:err_msg]
      page = noko_hash[:page]
      valid_links = scrub_link_hashes(link_hashes, url)
      valid_links = extract_link_from_url(valid_links, url)
      binding.pry
      valid_links
    end


    def extract_link_from_url(valid_links, url)
      formatted = valid_links.map do |link|
        binding.pry
        # link[:path] = URI(link[:path])&.path
        link[:path] = URI(link[:path])
        binding.pry
        link
      end
      formatted
    end


    def scrub_link_hashes(link_hashes, url)
      valid_hashes = link_hashes.map do |link_hsh|
        text_hsh = @text_scrub.scrub_strings([link_hsh[:text]])
        path_hsh = @path_scrub.scrub_strings([link_hsh[:path]])
        text = evaluate_scrub_hsh(text_hsh)
        path = evaluate_scrub_hsh(path_hsh)
        link_hsh = nil unless (text.present? || path.present?)
        link_hsh
      end
      valid_hashes.compact
    end


    def evaluate_scrub_hsh(hsh)
      hsh = hsh.first
      string = nil
      string = hsh[:string] if (hsh[:pos_criteria].any? && hsh[:neg_criteria].empty?)
    end



    def old_but_important
      temp_name = nil
      stock_hsh = get_stocks(temp_name)
      stock_texts = stock_hsh[:stock_texts]
      stock_links = stock_hsh[:stock_links]

      link_text_results = []
      noko_page.links.each do |noko_text_link|
        noko_text = noko_text_link.text&.downcase&.gsub(/\W/,'')
        pre_noko_link = noko_text_link&.path&.downcase&.strip
        noko_link = @formatter.format_link(url, pre_noko_link)

        if (noko_text && noko_link) && (noko_text.length > 3 && noko_link.length > 3) && (check_text_link_ban(noko_link, noko_text, temp_name) != true)
          ## Find any Texts or Links that include 'team' or 'staff'
          if noko_text.include?('staff') || noko_link.include?('staff')
            link_text_hsh = {staff_text: noko_text, staff_link: noko_link}
            link_text_results << link_text_hsh
          end

          ## Find valid Links
          stock_links.each do |stock_link|
            stock_link = stock_link.downcase&.strip
            if noko_link.include?(stock_link) || stock_link.include?(noko_link)
              link_text_hsh = {staff_text: noko_text, staff_link: noko_link}
              link_text_results << link_text_hsh
            end
          end

          ## Find valid Texts
          stock_texts.each do |stock_text|
            stock_text = stock_text.downcase&.gsub(/\W/,'')
            if noko_text.include?(stock_text) || stock_text.include?(noko_text)
              link_text_hsh = {staff_text: noko_text, staff_link: noko_link}
              link_text_results << link_text_hsh
            end
          end
        end
      end

      link_text_results.uniq!
      puts "\n\n===================="
      puts "Valid Text and Links: #{link_text_results.count}"
      puts link_text_results.inspect
      # sleep(1)
      return link_text_results
    end


    # def get_stocks(temp_name)
    #   special_templates = ["Cobalt", "Dealer Inspire", "DealerFire"]
    #   temp_name = 'general' if !special_templates.include?(temp_name)
    #
    #   stock_texts = Term.where(sub_category: "staff_text").where(criteria_term: temp_name).map(&:response_term)
    #   # stock_texts += @tally_staff_texts
    #   # stock_texts.uniq!
    #
    #   stock_links = Term.where(sub_category: "staff_path").where(criteria_term: temp_name).map(&:response_term)
    #   # stock_links += @tally_staff_links
    #   # stock_links.uniq!
    #
    #   stock_hsh = {stock_texts: stock_texts, stock_links: stock_links}
    #   # puts stock_hsh
    #   # sleep(1)
    #   return stock_hsh
    # end



    # def get_query
    #   err_sts_arr = ['Error: Timeout', 'Error: Host', 'Error: TCP']
    #
    #   query = Web.select(:id)
    #     .where(url_sts: 'Valid', page_sts: "Invalid")
    #     .where('page_date < ? OR page_date IS NULL', @cut_off)
    #     .or(Web.select(:id)
    #       .where(url_sts: 'Valid', temp_sts: 'Valid', page_sts: ['Valid', nil])
    #       .where('page_date < ? OR page_date IS NULL', @cut_off)
    #     ).or(Web.select(:id)
    #        .where(url_sts: 'Valid', temp_sts: 'Valid', page_sts: err_sts_arr)
    #        .where('timeout < ?', @db_timeout_limit)
    #     ).order("timeout ASC").pluck(:id)
    # end
    #
    # def start_find_page
    #   query = get_query[0..20]
    #   while query.any?
    #     setup_iterator(query)
    #     query = get_query[0..20]
    #     break if !query.any?
    #   end
    # end
    #
    # def setup_iterator(query)
    #   @query_count = query.count
    #   (@query_count & @query_count > @obj_in_grp) ? @group_count = (@query_count / @obj_in_grp) : @group_count = 2
    #   @dj_on ? iterate_query(query) : query.each { |id| template_starter(id) }
    # end
    #
    #
    # def template_starter(id)
    #   web = Web.find(id)
    #   web.links.destroy_all
    #   url = web.url
    #   temp_name = web.temp_name
    #   db_timeout = web.timeout
    #   db_timeout == 0 ? timeout = @dj_refresh_interval : timeout = (db_timeout * 3)
    #   puts "timeout: #{timeout}"
    #   puts "temp_name: #{temp_name}"
    #   puts url
    #
    #   noko_hsh = start_noko(url, timeout)
    #   noko_page = noko_hsh[:noko_page]
    #   err_msg = noko_hsh[:err_msg]
    #
    #   if err_msg.present?
    #     puts err_msg
    #     web.update(page_sts: err_msg, page_date: Time.now, timeout: timeout)
    #   elsif noko_page.present?
    #     link_text_results = scrub_link_hashes(noko_page, web)
    #     if !link_text_results.any?
    #       web.update(page_sts: 'Invalid', page_date: Time.now, timeout: timeout)
    #     else
    #       link_text_results.each do |link_text_hsh|
    #         link_obj = Link.find_or_create_by(link_text_hsh)
    #         web_link = web.links.where(id: link_obj).exists?
    #         web.links << link_obj if !web_link.present?
    #         web.update(page_sts: 'Valid', page_date: Time.now, timeout: 0)
    #       end
    #     end
    #   end
    # end



    ############ HELPER METHODS BELOW ################


    def check_text_link_ban(staff_link, staff_text, temp_name)
      return true if !staff_link.present? || !staff_text.present? || staff_link.length < 4
      return true if (temp_name = "Cobalt" && staff_text == 'sales')
      return true if check_link_ban(staff_link)
      return true if check_text_ban(staff_text)

      include_ban = %w(/#card-view/card/ 404 appl approve body career center click collision commercial contact customer demo direction discl drive employ espanol espaol finan get google guarantee habla history home hour inventory javascript job join lease legal location lube mail map match multilingual offers oil open opportunit parts phone place price quick rating review sales_tab schedule search service special start yourdeal survey tel test text trade value vehicle video virtual websiteby welcome why facebook commercial twit near dealernear educat faculty discount event year fleet build index amenit tire find award year blog)

      banned_link_text = include_ban.find { |ban| staff_link.include?(ban) || staff_text.include?(ban) }
      banned_link_text.present? ? true : false
    end


    def check_text_ban(staff_text)
      if staff_text.present?
        ## Make sure staff_text is downcase and compact like below for accurate comparisons.
        banned_texts = %w(dealershipinfo porsche preowned aboutus ourdealership newcars cars about honda ford learnmoreaboutus news fleet aboutourdealership fordf150 fordtrucks fordtransitconnectwagon fordtransitconnectwagon fordecosport fordfusion fordedge fordfocus fordescape fordexpedition fordexpeditionmax fordcmaxhybrid fordexplorer fordcars fordflex fordtransitcargovan fordsuvs fordtransitconnect fordtransitwagon fordtransitconnectvan fordfusionenergi fordvans fordfusionhybrid fordmustang moreaboutus tourournewdealership tourourdealership)

        banned_text = banned_texts.find { |ban| staff_text == ban }
        banned_text.present? ? true : false
      end
    end


    def check_link_ban(staff_link)
      if staff_link.present?
        link_strict_ban = %w(/about /about-us /about-us.htm /about.htm /about.html /#commercial /commercial.html /dealership/about.htm /dealeronlineretailing_d /dealeronlineretailing /dealership/department.htm /dealership/news.htm /departments.aspx /fleet /index.htm /meetourdepartments /sales.aspx /#tab-sales)

        banned_link = link_strict_ban.find { |ban| staff_link == ban }
        banned_link.present? ? true : false
      end
    end





  end
end
