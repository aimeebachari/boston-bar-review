import React, {Component} from 'react';

class Bar extends Component {
  constructor(props){
    super(props);

  }

  render(){
    let bar = <a href={`bars/${this.props.bar.id}`}>{this.props.bar.name}</a>;


    return(
      <div>
        {bar}
      </div>
    );
  }
}

export default Bar;
