@CreateNewMeetupForm = React.createClass
  displayName: "CreateNewMeetupForm"
  getInitialState: ->
    {
      title: ""
      description: ""
    }

  fieldChanged: (fieldName, event) ->
    stateUpdate = {}
    stateUpdate[fieldName] = event.target.value
    @setState(stateUpdate)

  titleChanged: (event) ->
    @setState(title: event.target.value)

  descriptionChanged: (event) ->
    @setState(description: event.target.description)

  render: ->
    <div className="form-horizontal">
      <fieldset>
        <legend>
          New Meetup
        </legend>
        <FormInputWithLabel labelText="Title" id="title" placeholder="Meetup Title" value=@state.title onChange={ @fieldChanged.bind(null, 'title') } />
        <FormTextAreaWithLabel labelText="Description" id="description" placeholder="Meetup description" value=@state.description onChange={ @fieldChanged.bind(null, 'description') } />
      </fieldset>
    </div>