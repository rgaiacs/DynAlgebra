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
    try {
        notebook.removeChild(old_preview);
    } catch (error) {
        console.log("No previous preview.");
    }
}

function add_equation() {
    var tex = document.getElementById('tex-input');
    var notebook = document.getElementById('notebook');
    var equation = TeXZilla.toMathML(tex.value, true, false, true);
    var math;

    math = equation.getElementsByTagName('mn');
    for (i = 0; i < math.length; i++) {
        mathmlFix(math[i]);
    }
    math = equation.getElementsByTagName('mi');
    for (i = 0; i < math.length; i++) {
        mathmlFix(math[i]);
    }

    jQuery(equation).find('*').each(mathmlSetup);
    notebook.appendChild(equation);
    notebook.appendChild(document.createTextNode(''));
    var bdel = mathmlCreateDelete(true);
    notebook.insertBefore(bdel, equation);
}
