import { severityLookup } from './mapLookups.js'

const options = {
    method: 'GET',
    mode: 'cors',
    headers: {
        'Content-Type': 'application/json; charset=utf-8'
    }
}

const getPopupInfo = async crash => {
    const crn = crash.crn
    const severity = crash.severity

    let output = {
        crn,
        severity,
    }

    const stream = await fetch(`https://alpha.dvrpc.org/api/crash-data/v1/crashes/${crn}`, options)
    
    // return an error message if the fetch fails
    if(!stream.ok) return {fail: stream.statusText, crn}

    // otherwise get the reponse body and combine it with the existing output fields
    let response = await stream.json()
    output = {...output, ...response}
    return output
}

const setPopup = (popupInfo, index, length) => {
    popupInfo.severity = severityLookup[popupInfo.severity]

    return `
        <h3 class="crash-popup-header">Crash Record Number: ${popupInfo.crn}</h3>
        <hr id="crash-popup-hr" />
        <ul id="crash-popup-ul">
            <li>Collision Type: ${popupInfo.collision_type}</li>
            <li>Max Severity: ${popupInfo.severity}</li>
            <li>Crash Date: ${popupInfo.month}, ${popupInfo.year}</li>
            <li>Vehicles involved: ${popupInfo.vehicle_count}</li>
            <li>Vehicle Occupants involved: ${popupInfo.vehicle_occupants}</li>
            <li>Pedestrians involved: ${popupInfo.ped_count}</li>
            <li>Bicyclists involved: ${popupInfo.bicycle_count}</li>
        </ul>
        <div id="crash-popup-pagination">
            <button id="crash-previous-popup"><</button>
            <p>${index} of ${length}</p>
            <button id="crash-next-popup">></button>
        </div>
    `
}

// handle popup failure
const catchPopupFail = crn => {
    return `
        <h3 class="crash-popup-header">Sorry!</h3>
        <p>Something went wrong and the data was unable to be fetched, please try again.</p>
        <p>If the issue persists, please contact <a href="mailto:kmurphy@dvrpc.org">kmurphy@dvrpc.org</a> and let him know the data for crash number <strong>${crn}</strong> is not available. Thank you. </p>
    `
}

export { getPopupInfo, setPopup, catchPopupFail }