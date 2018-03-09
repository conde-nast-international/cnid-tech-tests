import React, {Component} from 'react';

const withFetching = (url) => (Comp) =>
    class WithFetching extends Component {
        constructor(props) {
            super(props);
            this.url = url ? url : `/api${props.location.pathname}`;
            this.state = {
                data: [],
                isLoading: false,
                error: null
            };
        }

        componentDidMount() {
            this.setState({isLoading: true});

            fetch(this.url)
                .then(response => {
                    if (response.ok) {
                        return response.json();
                    } else {
                        throw new Error('Something went wrong ...');
                    }
                })
                .then(data => this.setState({data, isLoading: false}))
                .catch(error => this.setState({error, isLoading: false}));
        }

        render() {
            return <Comp { ...this.props } { ...this.state } />
        }
    }

export default withFetching;
