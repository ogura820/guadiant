module FamiliesHelper
  def chat_gpt_text
    Family.generate_story(current_user)
  end
end
