({
    doInit: function (component, event, helper) {
        component.set("v.columns", [
            {label: "Name", fieldName: "Name", type: "text"},
            {label: "Title", fieldName: "Title", type: "text"},
            {label: "Birthdate", fieldName: "Birthdate", type: "Date"},
            {label: "Phone", fieldName: "Phone", type: "Phone"},	
            {label: "Email", fieldName: "Email", type: "Email"}])
    },
})