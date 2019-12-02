import React from 'react';

import { handleRedirect } from '../history';

export const WelcomePage = () => {
    return (
        <>
            <h1>home</h1>
            <div>
                <h2>Startup</h2>
                <p>lorem ipsum lorem</p>
                <button onClick={() => handleRedirect('/startup')}>Join</button>
            </div>
            <div>
                <h2>Company</h2>
                <p>lorem ipsum lorem</p>
                <button onClick={() => handleRedirect('/investor')}>Join</button>
            </div>
        </>
    );
};
