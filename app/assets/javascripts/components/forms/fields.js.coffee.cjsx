@FormInputWithLabel = React.createClass
  displayName: "FormTextInputWithLabel"
  getDefaultProps: ->
    inputType: "text"
  render: ->
    <div className="form-group">
      <label htmlFor=@props.id className="col-lg-2 control-label">
        { @props.labelText }
      </label>
      <input className="form-control" placeholder=@props.placeholder id=@props.eid type=@props.inputType value=@props.title onChange=@props.onChange />
    </div>

@FormTextAreaWithLabel = React.createClass
  displayName: "FormTextAreaWithLabel"
  render: ->
    <div className="form-group">
      <label htmlFor=@props.id className="col-lg-2 control-label">
        { @props.labelText }
      </label>
      <textarea className="form-control" placeholder=@props.placeholder id=@props.eid onChange=@props.onChange >
        { @props.title }
      </textarea>
    </div>

@FormSubmitButton = React.createClass
  displayName: "FormSubmitButton"
  getDefaultProps: ->
    inputValue: "Save"
  render: ->
    <div className="form-group">
      <div className="col-lg-10 col-lg-offset-2">
        <input className="btn btn-primary" type='submit' value=@props.inputValue onClick=@props.onClick />
      </div>

    </div>

@FormButtonWithOnClick = React.createClass
  displayName: "FormButtonWithOnClick"
  getDefaultProps: ->
    inputValue: "Save"
  render: ->
    <div className="form-group">
      <div className="col-lg-10 col-lg-offset-2">
        <button className="btn btn-primary" type='button' onClick=@props.onClick>
          { @props.inputValue }
        </button>
      </div>

    </div>