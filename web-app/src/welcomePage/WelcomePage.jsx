import React from 'react';

import { history } from '../history';

export const WelcomePage = () => {
    const handleRedirect = route => {
        history.push(`/${route}`);
    };

    return (
        <>
            <h1>home</h1>
            <div>
                <h2>Startup</h2>
                <p>lorem ipsum lorem</p>
                <button onClick={() => handleRedirect('startup')}>Join</button>
            </div>
            <div>
                <h2>Company</h2>
                <p>lorem ipsum lorem</p>
                <button onClick={() => handleRedirect('company')}>Join</button>
            </div>
        </>
    );
};
