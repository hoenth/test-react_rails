@CreateNewMeetupForm = React.createClass
  displayName: "CreateNewMeetupForm"
  getInitialState: ->
    {
      meetup: {
        title: ""
        description: ""
        date: new Date()
        seoText: null
        technology_id: @props.technologies[0]["id"]
        guests: [""]
        errors: {
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
        technology_id: @state.meetup.technology_id
        guests: @state.meetup.guests
      } })

  fieldChanged: (fieldName, event) ->
    newState = $.extend(true, {}, @state)
    newState.meetup[fieldName] = event.target.value
    newState.meetup.errors[fieldName] = @validateField(fieldName, event.target.value)
    @setState(newState)

  seoChanged: (seoText) ->
    @state.meetup['seoText'] = seoText
    @forceUpdate()

  guestEmailChanged: (number, event) ->
    guests = @state.meetup.guests
    guests[number] = event.target.value
    lastEmail = guests[guests.length-1]
    penultimateEmail = guests[guests.length - 2]

    if (lastEmail != "")
      guests.push("")
    if (guests.length >= 2 && lastEmail == "" && penultimateEmail == "")
      guests.pop()
    ###
    // state is supposed to be immutable. But since state has a depth greater than 1
    // we would have to make a full copy of state, then use set state
    // It seems like this could cause problems since setState queues all of the changes
    // instead of acting on them at the time of the call
    // so one could envision that makeing a copy of state then setting state
    // could overwrite other changes to state
    ###
    @state.meetup.guests = guests
    @forceUpdate()


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
    for own fieldName of @validationRules()
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
        <FormSelectWithLabel
          labelText="Technology"
          id="technology_id"
          collection={ @props.technologies }
          valueField='id'
          displayField='name'
          onChange={ @fieldChanged.bind(null, 'technology_id') }
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
      <fieldset>
        <legend>
          Guests
        </legend>
          <FormSeparator>
          { for guest, n in @state.meetup.guests
            <FormInputWithLabel
                id="email"
                key="guest-#{n}"
                value={ guest }
                onChange={ @guestEmailChanged.bind(null, n) }
                placeholder="Email address of invitee"
                labelText="Email"
            />
          }
          </FormSeparator>
      </fieldset>
    </form>