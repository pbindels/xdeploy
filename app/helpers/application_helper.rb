module ApplicationHelper
  def body_classes
    body_classes = []
    body_classes << controller_name
    body_classes << action_name
    # TODO: uncomment after devise is added
    # body_classes << (user_signed_in? ? 'signed_in' : 'signed_out')
    body_classes.join(" ")
  end
end