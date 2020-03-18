import React, { Component } from 'react';

export class RootErrorBoundary extends Component {
    state = { error: '' };

    static getDerivedStateFromError(error) {
        return { error };
    }

    render() {
        if (this.state.error) {
            return (
                <>
                    <h1>Something went wrong. You should contact with site administrator</h1>
                    <p>{this.state.error}</p>
                </>
            );
        }

        return this.props.children;
    }
}
