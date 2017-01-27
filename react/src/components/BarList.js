import React from 'react';
import Bar from './Bar';

class BarList extends React.Component {
  constructor(props) {
    super(props);
    this.state = { bars: [] };
    this.getBars = this.getBars.bind(this);
  }

  componentDidMount(){
    this.getBars();
    setInterval(this.getBars, 15000);
  }

  getBars() {
    fetch('api/v1/bars',{
      credentials: "same-origin"
    }).then(response => {
      if (response.ok) {
        return response;
      } else {
        let errorMessage = `${response.status}, (${response.statusText})`;
        let error = new Error(errorMessage);
        throw(error);
      }
    })
    .then(response => response.json())
    .then(response => {
      let newBars = [];
      response.forEach(function(bar){
        newBars.push(bar);
      });
      newBars;
      this.setState({
        bars: newBars
      });
    });
  }


  render(){
    let bars = this.state.bars.map((bar)=>{
      return(
        <Bar
          key = {bar.id}
          bar = {bar}
        />
      );
    });

    return(
      <div>
        {bars}
      </div>
    );
  }
}

export default BarList;
