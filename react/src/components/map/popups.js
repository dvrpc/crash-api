import { severityLookup } from './mapLookups.js'


const options = {
    method: 'GET',
    mode: 'cors',
    headers: {
        'Content-Type': 'application/json; charset=utf-8'
    }
}

const getPopupInfo = async e => {
    const properties = e.features[0].properties
    const id = properties['crash_id']
    let severity = properties['max_sever']

    let output = {
        id,
        severity,
    }

    const stream = await fetch(`https://a.michaelruane.com/api/crash-data/v1/popupInfo?id=${id}`, options)
    
    // return an error message if the fetch fails
    if(!stream.ok) return {fail: stream.statusText, id}

    // otherwise get the reponse body and combine it with the existing output fields
    let response = await stream.json()
    response = response.features
    output = {...output, ...response}

    return output
}

const setPopup = (popupInfo, popup, map) => {
    popupInfo.severity = severityLookup[popupInfo.severity]

    popup.setHTML(`
        <h3 class="crash-popup-header">CRN: ${popupInfo.id}</h3>
        <hr />
        <p>Collision Type: ${popupInfo.collision_type}</p>
        <p>Max Severity: ${popupInfo.severity}</p>
        <p>Crash Date: ${popupInfo.month}, ${popupInfo.year}</p>
        <p>Number of persons involved: ${popupInfo.persons}</p>
        <p>Number of vehicles involved: ${popupInfo.vehicle_count}</p>
        <p>Number of pedestrians involved: ${popupInfo.ped}</p>
        <p>Number of bicyclists involved: ${popupInfo.bike}</p>
    `)
    .addTo(map)
}

// handle popup failure
const catchPopupFail = (popup, map, id) => {
    popup.setHTML(`
        <h3 class="crash-popup-header">Oops!</h3>
        <p>Something went wrong and the data was unable to be fetched, please try again.</p>
        <p>If the issue persists, please contact <a href="mailto:kmurphy@dvrpc.org">kmurphy@dvrpc.org</a> and let him know the data for crash number ${id} is not available. Thank you. </p>
    `)
    .addTo(map)
}

export { getPopupInfo, setPopup, catchPopupFail }