@CreateNewMeetupForm = React.createClass
  displayName: "CreateNewMeetupForm"
  getInitialState: ->
    {
      meetup: {
        title: ""
        description: ""
        date: new Date()
        seo: null
        errors: {
          title: null
        }
      }
    }

  formSubmitted: (event) ->
    return unless @validateForm()
    $.ajax
      url: "meetups.json",
      type: "POST",
      dataType: "JSON",
      contentType: "application/json",
      processData: false,
      data: JSON.stringify({ meetup: {
        title: @state.meetup.title
        description: @state.meetup.description
        date: "#{@state.meetup.date.getFullYear()}-#{@state.meetup.date.getMonth()+1}-#{@state.meetup.date.getDate()}"
        seo: @state.meetup.seo || @computeDefaultSeoText()
      } })

  fieldChanged: (fieldName, event) ->
    newState = $.extend(true, {}, @state)
    newState.meetup[fieldName] = event.target.value
    newState.meetup.errors[fieldName] = @validateField(fieldName, event.target.value)
    @setState(newState)

  seoChanged: (seoText) ->
    @setState(seoText: seoText)

  monthName: (monthNumberStartingFromZero) ->
    ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"][monthNumberStartingFromZero]

  useComputedSeoOrUserEntered: () ->
    if(@state.meetup.seoText?)
      @state.meetup.seoText
    else
      @computeDefaultSeoText()

  computeDefaultSeoText: () ->
    words = @state.meetup.title.toLowerCase().split(/\s+/)
    words.push(@monthName(@state.meetup.date.getMonth()))
    words.push(@state.meetup.date.getFullYear().toString())
    words.filter((string) ->
      string.trim().length > 0).join("-").toLowerCase()

  dateChanged: (newDate) ->
    @setState(date: newDate)

  validateField: (fieldName, value) ->
    validator = @validationRules()[fieldName]
    return unless validator
    validator(value)

  validateForm: () ->
    isValid = true
    newState = $.extend(true, {}, @state)
    for own fieldName, rule of @validationRules()
      error = @validateField(fieldName, @state.meetup[fieldName])
      console.log(error)

      if(error)
        newState.meetup['errors'][fieldName] = error
        isValid = false
    if !isValid
      @setState(newState)
    return isValid

  validationRules: () ->
    {
      title: (text) ->
        if /\S/.test(text) then null else "Cannot be blank"
    }


  render: ->
    <form className="form-horizontal" method="post" action="/meetups">
      <fieldset>
        <legend>
          New Meetup
        </legend>
        <FormInputWithLabel
            labelText="Title"
            id="title"
            placeholder="Meetup Title"
            value={ @state.meetup.title }
            onChange={ @fieldChanged.bind(null, 'title') }
            warning={ @state.meetup.errors.title }
        />
        <FormTextAreaWithLabel
            labelText="Description"
            id="description"
            placeholder="Meetup description"
            value={ @state.meetup.description }
            onChange={ @fieldChanged.bind(null, 'description') }
        />
        <DateWithLabel
            date={ @state.meetup.date }
            onChange={ @dateChanged }
        />
        <FormInputWithLabelAndReset
            id="seo"
            value={ @useComputedSeoOrUserEntered() }
            placeholder="SEO Text"
            labelText="SEO"
            onChange={ @seoChanged }
        />
        <FormButtonWithOnClick
            onClick={ @formSubmitted }
        />
      </fieldset>
    </form>