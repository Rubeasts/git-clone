# frozen_string_literal: true
module GetCloneData
  class ClonedRepo
    CLONED_REPO_PATH = File.expand_path(
      File.join(
        File.dirname(__FILE__), '..', '..', 'cloned_repo_tmp'
      )
    )

    def initialize(repo_path:)
      @repo_path = repo_path
    end

    def self.clone(git_url:)
      repo_path = self.get_repo_path(git_url: git_url)
      `git clone #{git_url} #{repo_path}`
      return nil unless Dir.exists? repo_path
      new(repo_path: repo_path)
    end

    def self.wipe
      `rm -R -f #{CLONED_REPO_PATH}/*`
    end

    def self.get_repo_path(git_url:)
      repository = git_url.gsub('.git','').split('/')[3,4]
      File.expand_path(
        File.join(
          CLONED_REPO_PATH, repository[0], repository[1]
        )
      )
    end

    def loc_in_folder(folder)
    	if Dir.exists? @repo_path
    	  loc_in_folder = `cloc #{@repo_path}/#{folder}`
          .split("SUM").last.split("\n").first.split(" ")[1..5]
          .map { |i| i.to_f }
    	end
    	# response is an array of [no of files, no blank lines, no comments, no code lines]
    	loc_in_folder if loc_in_folder
    end

    def loc_in_file(file)
    	if File.exists? @repo_path
    	  loc_in_file = `wc -l #{@repo_path}/#{file}`.split(" ").first.to_f
    	end
    	# response is fixnum of lines of code in file (no comments or blanks)
    	loc_in_file if loc_in_file
    end

    def get_flog_scores
      if Dir.exists? @repo_path
        flog_response = `flog #{@repo_path}`.split("\n")
          .map { |item| item.split(":").first.to_f }
    	end
    	# reponse is an array of all the flog scores from total , ave, each method...
    	flog_response if flog_response
    end

    def get_flay_score
      if Dir.exists? @repo_path
        `flay #{@repo_path}`.split("=").last.split("\n").first.to_f
      end
    end

    def get_rubocop_errors
    	holder = Array.new()
    	if Dir.exists? @repo_path
    	  rubocop_response = `rubocop #{@repo_path}`
    	  holder << rubocop_response.split("\n").last.split("files").first.to_f
    	  holder << rubocop_response.split("\n").last.split(",").last.split("offenses").first.to_f
    	end
    	# response is array [no. of files, no. of offenses]
    	holder
    end

    def get_loc
    	if Dir.exists? @repo_path
    	  loc_response = `cloc #{@repo_path}`.split("SUM").last.split("\n").first
          .split("    ")[2..5].map { |i| i.to_f }
    	end
    	loc_response
    end
  end
end
