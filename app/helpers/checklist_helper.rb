module ChecklistHelper
  def status_or_progress(checklist)
    if checklist.submit_at
      icon 'check-circle status', '提出済み'
    else
      valuenow = checklist.progression_rate
      opts = {
          role: 'progressbar',
          aria: {
              valuenow: valuenow,
              valuemin: '0',
              valuemax: '100'
          },
          style: "min-width: 2em; width: #{ valuenow }%;"
      }
      render inline: <<-HAML, type: :haml, locals: { opts: opts, valuenow: valuenow }
.progress.m-b-0
  .progress-bar.progress-bar-success{ opts }
    = "#{ valuenow }%"
      HAML
    end
  end
end
