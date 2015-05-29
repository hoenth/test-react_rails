@UnclickedClickLink =  React.createClass
  render: ->
    <a href='javascript:void(0)' onClick=@props.onClickEvent>
      Click Me
    </a>
@ClickedClickLink = React.createClass
  render: ->
    <span>
      You have been summarily clicked, you dog
    </span>

@OneTimeClickLink = React.createClass
  getInitialState: ->
    {clicked: false}
  linkClicked: (event) ->
    @setState(clicked: true)
  render: ->
    <div id="one_time_click_link">
      { unless @state.clicked
          <UnclickedClickLink onClickEvent=@linkClicked />
        else
          <ClickedClickLink />
      }
    </div>