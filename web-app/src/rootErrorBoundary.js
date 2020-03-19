import React, { Component } from 'react';

export class RootErrorBoundary extends Component {
    state = { hasErrorOcurred: false };

    static getDerivedStateFromError() {
        return { hasErrorOcurred: true };
    }

    render() {
        if (this.state.hasErrorOcurred) {
            return (
                <>
                    <h1>Something went wrong. You should contact with site administrator</h1>
                </>
            );
        }

        return this.props.children;
    }
}
