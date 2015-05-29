@CreateNewMeetupForm = React.createClass
  displayName: "CreateNewMeetupForm"
  getInitialState: ->
    {
      title: ""
      description: ""
    }

  formSubmitted: (event) ->
    $.ajax
      url: "meetups.json",
      type: "POST",
      dataType: "JSON",
      contentType: "application/json",
      processData: false,
      data: JSON.stringify({ meetup: @state })

  fieldChanged: (fieldName, event) ->
    stateUpdate = {}
    stateUpdate[fieldName] = event.target.value
    @setState(stateUpdate)

  render: ->
    <form className="form-horizontal">
      <fieldset>
        <legend>
          New Meetup
        </legend>
        <FormInputWithLabel labelText="Title" id="title" placeholder="Meetup Title" value=@state.title onChange={ @fieldChanged.bind(null, 'title') } />
        <FormTextAreaWithLabel labelText="Description" id="description" placeholder="Meetup description" value=@state.description onChange={ @fieldChanged.bind(null, 'description') } />
        <FormButtonWithOnClick onClick=@formSubmitted />
      </fieldset>
    </form>