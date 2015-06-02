###
//  Creates an input field with a label. Assumes an onChange event
//  handler will be included in the props along with the following:
//    value - The value of the field
//    labelText - The text label to be display with the field
//    id - An id to identifiy the field and the label's for value
###
@FormInputWithLabel = React.createClass
  displayName: "FormTextInputWithLabel"

  getDefaultProps: ->
    inputType: "text"

  render: ->
    <div className="form-group">
      <label htmlFor={ @props.id } className="col-sm-2 control-label">
        { @props.labelText }
      </label>
      <div className={ React.addons.classSet(' col-sm-10': true, 'has-error': @props.warning) }>
        <input className="form-control" placeholder={ @props.placeholder } id={ @props.id } type={ @props.inputType } value={ @props.value } onChange={ @props.onChange } />
        <WarningLabel warning={ @props.warning } />
      </div>
    </div>

###
//  Creates an input field with a label anda onchange event that is self publishing.
//  Includes buttons to clear the field or reset it
//  Assumes an onChange event
//  handler will be included in the props along with the following:
//    value - The value of the field
//    labelText - The text label to be display with the field
//    id - An id to identifiy the field and the label's for value
###
@FormInputWithLabelAndReset = React.createClass
  displayName: "FormInputWithLabelAndReset"
  getDefaultProps: ->
    inputType: "text"

  onChange: (event) ->
    @props.onChange(event.target.value)

  onChangeNull: (event) ->
    @props.onChange(null)

  onChangeBlank: (event) ->
    @props.onChange("")

  render: ->
    <div className="form-group">
      <label htmlFor={ @props.id } className="col-sm-2 control-label">
        { @props.labelText }
      </label>
      <div className="col-sm-10">
        <div className="input-group">
          <input className="form-control" placeholder={ @props.placeholder } id={ @props.id } type={ @props.inputType } value={ @props.value } onChange={ @onChange } />
          <div className='input-group-addon'>
            <button onClick={ @onChangeNull } className="btn btn-default" type="button"  } >
              <i className="fa fa-magic" />
            </button>
            <button onClick={ @onChangeBlank } className="btn btn-default" type="button"  } >
              <i className="fa fa-times-circle" />
            </button>
          </div>
        </div>
      </div>
    </div>


###
//  Creates an text area field with a label. Assumes an onChange event
//  handler will be included in the props along with the following:
//    value - The value of the field
//    labelText - The text label to be display with the field
//    id - An id to identifiy the field and the label's for value
###
@FormTextAreaWithLabel = React.createClass
  displayName: "FormTextAreaWithLabel"
  render: ->
    <div className="form-group">
      <label htmlFor={ @props.id } className="col-sm-2 control-label">
        { @props.labelText }
      </label>
      <div className="col-sm-10">
        <textarea className="form-control" placeholder={ @props.placeholder } id={ @props.id } onChange={ @props.onChange } value={ @props.value } />
      </div>
    </div>


@FormSubmitButton = React.createClass
  displayName: "FormSubmitButton"
  getDefaultProps: ->
    inputValue: "Save"
  render: ->
    <div className="form-group">
      <div className="col-sm-10 col-lg-offset-2">
        <input className="btn btn-primary" type='submit' value={ @props.inputValue } onClick={ @props.onClick } />
      </div>

    </div>


@FormButtonWithOnClick = React.createClass
  displayName: "FormButtonWithOnClick"
  getDefaultProps: ->
    inputValue: "Save"
  render: ->
    <div className="form-group">
      <div className="col-sm-2"/>
      <div className="col-sm-10 col-lg-offset-2">
        <button className="btn btn-primary" type='button' onClick={ @props.onClick }>
          { @props.inputValue }
        </button>
      </div>

    </div>

@DateWithLabel = React.createClass
  displayName: "DateWithLabel"

  onYearChange: (event) ->
    newDate = new Date(
      event.target.value,
      @props.date.getMonth(),
      @props.date.getDate()
      )
    @props.onChange(newDate)

  onMonthChange: (event) ->
    newDate = new Date(
      @props.date.getFullYear(),
      event.target.value,
      @props.date.getDate()
      )
    @props.onChange(newDate)

  onDayChange: (event) ->
    newDate = new Date(
      @props.date.getFullYear(),
      @props.date.getMonth(),
      event.target.value
      )
    @props.onChange(newDate)

  dayName: (date) ->
    dayNameStartingWithSundayZero = new Date(
      @props.date.getFullYear(),
      @props.date.getMonth(),
      date
      ).getDay()
    ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"][dayNameStartingWithSundayZero]

  monthName: (monthNumberStartingFromZero) ->
    ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"][monthNumberStartingFromZero]

  render: ->
    <div className="form-group">
      <label className="col-sm-2 control-label">
        Date
      </label>
      <div className="col-sm-2">
        <select className="form-control" value={ @props.date.getFullYear() } onChange= { @onYearChange }>
          { <option value={ year } key={ year }>{ year }</option> for year in [2014..2018] }
        </select>
      </div>
      <div className="col-sm-2">
        <select className="form-control" value={ @props.date.getMonth() } onChange= { @onMonthChange }>
          { <option value={ month } key={ month }>{ "#{month + 1 }-#{@monthName(month)}" }</option> for month in [0..11] }
        </select>
      </div>
      <div className="col-sm-2">
        <select className="form-control" value={ @props.date.getDate() } onChange= { @onDateChange }>
          { <option value={ day } key={ day }>{ "#{day}-#{@dayName(day)}" }</option> for day in [1..31] }
        </select>
      </div>
    </div>

@WarningLabel = React.createClass
  displayName: "WarningLabel"
  render: ->
    return null unless @props.warning
    <div className="control-label" htmlFor={ @props.id }>
      { @props.warning }
    </div>