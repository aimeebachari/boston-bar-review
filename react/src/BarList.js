import React from 'react';

class BarList extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      name: ""
    };

  }

  componentDidMount(){
    fetch('api/v1/bars',{
      credentials: "same-origin"
    }).then(response => {
      response.json();
    }).then(response=>{debugger;
      this.setState({bars:response.bars});
    });
  }

  render(){
    let bars = this.state.bars;
    return(
      <div>
        {name}
      </div>
    );
  }
}

export default BarList;
