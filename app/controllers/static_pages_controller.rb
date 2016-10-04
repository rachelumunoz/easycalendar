class StaticPagesController < ApplicationController
  render json: { summary: $event.summary }

  def set_google_event_token
    if request['code'] == nil
      redirect_to($event.authorization_url)
    else
      $event.save_credentials(request['code'])
      redirect_to('/')
    end
  end
end
