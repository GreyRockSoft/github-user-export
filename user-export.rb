require "thor"
require "octokit"
require "faraday"
require "csv"

class ExportCli < Thor
    desc "export team [outputFile]", "export users lists from a github team"
    def export(team, filename=nil)
        if filename.nil? 
            filename = team + ".csv"
        end
        puts "Exporting team #{team} to #{filename}"
        get_user_list(team, filename)
        puts "Finished exporting users details"
    end

    desc "teams org", "list all the teams that belong to an organization"
    def teams(organization)
       get_team_list(organization) 
    end

    private

    def get_client
        #stack = Faraday::RackBuilder.new do |builder|
        #      builder.response :logger
        #      builder.use Octokit::Response::RaiseError
        #      builder.adapter Faraday.default_adapter
        #end
        #Octokit.middleware = stack
        Octokit.auto_paginate = true
        client = Octokit::Client.new(:netrc => true)
        client.login
        return client
    end

    def get_user_list(team, filename)
        CSV.open(filename, "wb") do |csv|
            client = get_client
            client.get("/teams/#{team}/members", per_page: 100).each do |member|
                member_details = client.get("/users/#{member.login}")
                printf "."
                csv << [member.login, member_details.name]
            end
        end
        puts ""
     end

    def get_team_list(org)
        client = get_client
        client.org(org + "/teams").each do |team|
            puts "#{team.name}: #{team.id}"
        end
    end
end

ExportCli.start(ARGV)
