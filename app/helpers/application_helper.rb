module ApplicationHelper
  def full_title page_title = ""
    base_title = t "base_title"
    page_title.empty? ? base_title : page_title + " | " + base_title
  end

  def btn_add_answer name, f, association
    new_answer = f.object.send(association).klass.new
    id = new_answer.object_id
    fields = f.fields_for(association, new_answer, child_index: id) do |builder|
      render "admin/words/answer_row", f: builder
    end
    link_to name, "#", class: "btn btn-link btn-add-answer",
      data: {id: id, fields: fields.gsub("\n", "")}
  end
end
