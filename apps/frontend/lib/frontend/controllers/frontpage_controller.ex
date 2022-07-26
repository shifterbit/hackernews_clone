defmodule Frontend.FrontpageController do
  use Frontend, :controller

  def index(conn, _params) do
    id = get_session(conn, :user_id)

    submissions =
      Backend.get_submissions(30)
      |> Enum.map(fn submission ->
        points = Backend.get_submission_upvote_count(submission.id)

        %{
          data: submission,
          user: Backend.get_user(submission.user_id),
          is_upvoted: Backend.is_upvoted_by?(id, submission.id, :submission),
          points: points,
          comments: Backend.get_comment_count(submission.id),
          ranking: Backend.get_ranking(points, submission.submitted_at),
          timestamp: Timestamp.relative_timestamp(submission.submitted_at)
        }
      end)

    render(conn, "index.html", submissions: submissions)
  end
end
