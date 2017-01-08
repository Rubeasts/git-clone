# frozen_string_literal: true
module GetCloneData
  class ClonedRepo
    CLONED_REPO_PATH = File.expand_path(
      File.join(
        File.dirname(__FILE__), '..', '..', 'cloned_repo_tmp'
      )
    )

    @@itt = 0

    attr_reader :repo_path

    def initialize(repo_path:)
      @repo_path = repo_path
    end

    def self.clone(git_url:)
      repo_path = self.get_repo_path(git_url: git_url)
      `git clone --depth=1 #{git_url} #{repo_path}`
      return nil unless Dir.exists? repo_path
      new(repo_path: repo_path)
    end

    def self.wipe
      `rm -R -f #{CLONED_REPO_PATH}/*`
    end

    def wipe
      `rm -R -f #{@repo_path}`
    end

    def self.get_repo_path(git_url:)
      owner, repo = git_url.gsub('.git','').split('/')[3,4]
      File.expand_path(
        File.join(
          CLONED_REPO_PATH, owner, repo, itt.to_s
        )
      )
    end

    def self.itt
      @@itt = @@itt + 1
      @@itt
    end

    def ruby_files
      return @ruby_files if @ruby_files

      path_rb_expander = PathExpander.new [@repo_path], "**/*.{rb,rake}"
      @ruby_files = path_rb_expander.process
      @ruby_files
    end

    def get_flog_scores
      if Dir.exist? @repo_path
        flog = Flog.new
        flog.flog(*ruby_files)
        #flog.calculate_total_score
        flog_response = {
          total_score: flog.total_score,
          max_score: flog.max_score,
          average: flog.average
        }
      end
      # reponse is an array of all the flog scores from total , ave, each method...
      flog_response if flog_response
    end

    def get_flay_score
      if Dir.exist? @repo_path
        flay = Flay.new
        flay.process(*ruby_files)
        flay.analyze
        flay = flay.summary.values.first
      end
      flay if flay
    end

    def get_rubocop_errors
      if Dir.exist? @repo_path
        rubocop_response = `cd #{@repo_path} ; rubocop --format json`
        summary = JSON.parse(rubocop_response, :symbolize_names => true)[:summary]
        summary
      end
    end

    def get_loc
      if Dir.exist? @repo_path
        loc_response = `cloc #{@repo_path}`
        if loc_response.empty?
          loc_response = nil
        else
          loc_response = loc_response.split('SUM').last.split("\n").first
            .split('    ')[2..5].map(&:to_f)
        end
      end
      loc_response
    end
  end
end
