class Ride < ActiveRecord::Base
  belongs_to :user
  belongs_to :attraction

  def take_ride
    if check_user_height && user_ticket_balance
      user_ticket_payment
      calculate_user_nausea
      calculate_user_happiness
      "Thanks for riding the #{attraction.name}!"
    else
      if !check_user_height && !user_ticket_balance
        "Sorry. You do not have enough tickets the #{attraction.name}. You are not tall enough to ride the #{attraction.name}."
      elsif !check_user_height
        "Sorry. You are not tall enough to ride the #{attraction.name}."
      else
        "Sorry. You do not have enough tickets the #{attraction.name}."
      end
    end
  end

  private

    def check_user_height
      user.height >= attraction.min_height
    end

    def user_ticket_balance
      user.tickets >= attraction.tickets
    end

    def user_ticket_payment
      user.update(tickets: user.tickets - attraction.tickets)
    end

    def calculate_user_nausea
      user.update(nausea: user.nausea + attraction.nausea_rating)
    end

    def calculate_user_happiness
      user.update(happiness: user.happiness + attraction.happiness_rating)
    end


end
