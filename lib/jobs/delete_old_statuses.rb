class DeleteOldStatuses
  def run
    ids = Status.where("created_at < ?", 30.days.ago)

    if ids.size > 0
      Status.destroy(ids)
      puts "#{ids.size} statuses have been deleted!"
    else
      puts "No statuses have been deleted."
    end
  end
end

# START:run
DeleteOldStatuses.new.run
# END:run