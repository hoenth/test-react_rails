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
      <label htmlFor=@props.id className="col-lg-2 control-label">
        { @props.labelText }
      </label>
      <div className="col-sm-10">
        <input className="form-control" placeholder={ @props.placeholder } id={ @props.eid } type={ @props.inputType } value={ @props.value } onChange={ @props.onChange } />
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
      <label htmlFor={ @props.id } className="col-lg-2 control-label">
        { @props.labelText }
      </label>
      <div className="col-sm-10">
        <textarea className="form-control" placeholder={ @props.placeholder } id={ @props.eid } onChange={ @props.onChange } >
          { @props.value }
        </textarea>
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

  monthName: (monthNumberStartingFromZero) ->
    ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"][monthNumberStartingFromZero]

  dayName: (date) ->
    dayNameStartingWithSundayZero = new Date(
      @props.date.getFullYear(),
      @props.date.getMonth(),
      date
      ).getDay()
    ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"][dayNameStartingWithSundayZero]

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