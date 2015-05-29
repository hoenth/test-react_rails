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