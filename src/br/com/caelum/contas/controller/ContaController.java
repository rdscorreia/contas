package br.com.caelum.contas.controller;

import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import br.com.caelum.contas.dao.ContaDAO;
import br.com.caelum.contas.modelo.Conta;

@Controller
public class ContaController {

	private ContaDAO dao;

	@Autowired
	public ContaController(ContaDAO dao) {
		this.dao = dao;
	}

	@RequestMapping(value = "form")
	public String form() {
		return "conta/formulario";
	}

	@RequestMapping("adicionaConta")
	public String adiciona(@Valid Conta conta, BindingResult results) {

		// se tiver erro redirecione para o formulario
		if (results.hasErrors()) {
			return "conta/formulario";
		}

		dao.adiciona(conta);
		return "conta/conta-adicionada";
	}

	/*
	 * @RequestMapping("pagaConta") public String paga(Conta conta) { ContaDAO dao =
	 * new ContaDAO(); dao.paga(conta.getId()); return "redirect:listaContas"; }
	 */

	@RequestMapping("pagaConta")
	public void paga(Conta conta, HttpServletResponse response) {
		dao.paga(conta.getId());

		response.setStatus(200);
	}

	@RequestMapping("removeConta")
	public String remove(Conta conta) {
		dao.remove(conta);
		return "redirect:listaContas";
	}

	@RequestMapping("mostraConta")
	public ModelAndView mostra(Long id) {

		ModelAndView mv = new ModelAndView("conta/mostra");
		mv.addObject("conta", dao.buscaPorId(id));
		return mv;

	}

	@RequestMapping("alteraConta")
	public String altera(Conta conta) {
		dao.altera(conta);
		return "redirect:listaContas";
	}

	@RequestMapping("listaContas")
	public ModelAndView lista() {
		List<Conta> contas = dao.lista();

		ModelAndView mv = new ModelAndView("conta/lista");
		mv.addObject("contas", contas);
		return mv;
	}
}
