import React from 'react';
import { handleRedirect } from '../history';

export const InvestorTypePage = () => (
    <div>
        <h1>Investor type</h1>
        <p>Choose your type</p>
        <button onClick={() => handleRedirect('/investor/company')}>Company</button>
        <button onClick={() => handleRedirect('/investor/individual')}>Individual</button>
    </div>
);
