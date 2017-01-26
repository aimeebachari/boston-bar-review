import React from 'react';

class BarList extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      name: ""
    };

    this.handleSubmit = this.handleSubmit.bind(this);
    this.handleName = this.handleName.bind(this);
  }

  handleName(event) {
    this.setState({ name: event.target.value });
  }

  handleSubmit(event) {
    event.preventDefault();
    // let barList = this.state.barList;
    // this.setState({ bars: barList });
  }

  // componentDidMount(){
  //   // fetch('api/v1/bars',{
  //   //   method: 'post',
  //   //   credentials: 'same-origin'
  //   // }).then(response=>{
  //   // });
  //   fetch('api/v1/bars',{
  //
  //   }).then(response => {
  //     response.json();
  //   }).then(response=>{
  //     this.setState({bars:response.bars});
  //   });
  // }

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
