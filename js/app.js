function preview_equation() {
    var tex = document.getElementById('tex-input');
    var notebook = document.getElementById('tex-preview');
    var equation;
    try {
        equation = TeXZilla.toMathML(tex.value, true, false, true);
    } catch (error) {
        equation = document.createElement("p");
        equation.setAttribute("style", "color:red;");
        equation.innerHTML = tex.value;
    }
    equation.setAttribute('id', 'preview');
    old_preview = document.getElementById('preview');
    notebook.insertBefore(equation, old_preview);
    notebook.removeChild(old_preview);
}

function add_equation() {
    var tex = document.getElementById('tex-input');
    var notebook = document.getElementById('notebook');
    var equation = TeXZilla.toMathML(tex.value, true, false, true);
    jQuery(equation).find('*').each(mathmlSetup);
    notebook.appendChild(equation);
    notebook.appendChild(document.createTextNode(''));
    var bdel = mathmlCreateDelete(false);
    notebook.insertBefore(bdel, equation);
}
